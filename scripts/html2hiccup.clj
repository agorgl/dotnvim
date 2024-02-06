#!/usr/bin/env bb
(ns html2hiccup
  (:require
   [babashka.pods :as pods]
   [babashka.deps :as deps]
   [clojure.string :as str]
   [clojure.walk :as walk]))

(pods/load-pod 'retrogradeorbit/bootleg "0.1.9")
(deps/add-deps '{:deps {zprint/zprint {:mvn/version "1.2.8"}}})
(deps/add-deps '{:deps {camel-snake-kebab/camel-snake-kebab {:mvn/version "0.4.3"}}})

(require '[pod.retrogradeorbit.bootleg.utils :refer [convert-to]]
         '[zprint.core :refer [zprint-str]]
         '[camel-snake-kebab.core :as csk])

(defn remove-html-whitespace [in]
  (let [re #"((?<=>)\s+|\s+(?=<))"]
    (str/replace in re "")))

(defn munge-html-tags [in]
  (let [re #"(</?\s*)(\p{Lu}[^\s>]*)([^>]*)(\s*/?>)"
        mfn (fn [[_ prefix tag-name attrs suffix]]
              (let [tag (csk/->kebab-case tag-name)]
                (str prefix "x-" tag attrs suffix)))]
    (str/replace in re mfn)))

(defn demunge-hiccup-tags [in]
  (walk/postwalk
   (fn [x]
     (if (and (vector? x) (str/starts-with? (name (first x)) "x-"))
       (into [:> (-> (first x)
                     (name)
                     (str/replace #"^x-" "")
                     (csk/->PascalCaseSymbol))]
             (rest x))
       x))
   in))

(defn map-hiccup-attrs [in]
  (walk/postwalk
   (fn [x]
     (if (and (vector? x)
              (or (keyword? (first x)) (symbol? (first x)))
              (map? (second x)))
       (let [attrs
             (->> (second x)
                  (map (fn [[k v]]
                         (let [k (case k
                                   :classname :class
                                   :viewbox :viewBox
                                   :baseprofile :baseProfile
                                   k)
                               v (cond
                                   (= v "") true
                                   :else v)]
                           [k v])))
                  (into {}))]
         (assoc-in x [1] attrs))
       x))
   in))

(defn format-hiccup [in]
  (-> in
      (zprint-str
       {:style :hiccup
        :map {:comma? false :force-nl? true}
        :vector {:force-nl? true}
        :width 4096})))

(-> (slurp *in*)
    (remove-html-whitespace)
    (munge-html-tags)
    (convert-to :hiccup-seq)
    (->> (map #(-> %
                   map-hiccup-attrs
                   demunge-hiccup-tags
                   format-hiccup))
         (str/join "\n"))
    (println))
