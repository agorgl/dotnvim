#!/usr/bin/env bb
(ns html2hiccup
  (:require
   [babashka.pods :as pods]
   [babashka.deps :as deps]
   [clojure.string :as str]))

(pods/load-pod 'retrogradeorbit/bootleg "0.1.9")
(deps/add-deps '{:deps {zprint/zprint {:mvn/version "1.2.8"}}})

(require '[pod.retrogradeorbit.bootleg.utils :refer [convert-to]]
         '[zprint.core :refer [zprint]])

(-> (slurp *in*)
    (str/replace #"((?<=>)\s+|\s+(?=<))" "")
    (str/replace #"className=\"" "class=\"")
    (convert-to :hiccup-seq)
    (->> (run! #(zprint % {:style :hiccup
                           :map {:comma? false :force-nl? true}
                           :vector {:force-nl? true}
                           :width 4096}))))
