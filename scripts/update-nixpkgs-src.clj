#! /usr/bin/env nix-shell
#! nix-shell shell.nix -i bb

(require '[clojure.string :as str]
         '[clojure.java.shell :refer [sh]]
         '[selmer.parser :refer [render]])

(defn info
  [& msgs]
  (apply (partial println "[INFO]") msgs))

(defn retrieve-last-commit-from-branch
  [branch]
  (let [remote (str "refs/heads/" branch)]
    (-> (sh "git" "ls-remote" "git://github.com/NixOS/nixpkgs" remote)
        :out
        str/trim-newline
        (str/split #"\t")
        first)))

(defn branch->nixpkgs-url
  [commit]
  (str "https://github.com/nixos/nixpkgs/archive/" commit ".tar.gz"))

(defn nix-prefetch-commit-from-url
  [url]
  (-> (sh "nix-prefetch-url" "--unpack" url)
      :out
      str/trim-newline))

(defn generate-nixpkgs-src
  [url sha256]
  (->> (render
"{ system ? builtins.currentSystem, ... }:

import (builtins.fetchTarball {
  url = \"{{url}}\";
  sha256 = \"{{sha256}}\";
}) {
  inherit system;
  config = { allowUnfree = true; };
}" {:url    url
    :sha256 sha256})
       (spit "nixpkgs-src.nix")))

(defn main [& args]
  (let [branch      (or (-> args flatten first) "nixpkgs-unstable")
        _           (info "Using branch" branch)
        commit      (retrieve-last-commit-from-branch branch)
        nixpkgs-url (branch->nixpkgs-url commit)]
    (assert commit "Commit shouldn't be empty!")
    (info "Using commit" commit)
    (info "Prefetching and computing SHA256...")
    (let [sha256 (nix-prefetch-commit-from-url nixpkgs-url)]
      (assert sha256 "SHA256 shouldn't be empty!")
      (info "Generating new 'nixpkgs-src.nix'...")
      (generate-nixpkgs-src nixpkgs-url sha256))
    (info "Done!")))

(when (= *file* (System/getProperty "babashka.file"))
  (main *command-line-args*))
