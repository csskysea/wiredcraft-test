#!/bin/bash

#for ns in (zara wiredcraft tiffany-staging tiffany-qa tiffany-dev swire suitsupply lululemon demo bulgari);
ns_array=(zara wiredcraft tiffany-staging tiffany-qa tiffany-dev swire suitsupply lululemon demo bulgari)
for ns in "${ns_array[@]}";do
for cj in $(kubectl get cronjobs -n "$ns" -o name); do
current_concurrency_policy=$(kubectl --context=k8s-staging get $cj -n $ns -o jsonpath='{.spec.concurrencyPolicy}')
echo "namnespace:$ns,cronjob name:$cj,current concurrency plicy:$current_concurrency_policy"
kubectl --context=k8s-staging  patch $cj  -n $ns -p '{"spec" : {"successfulJobsHistoryLimit": 3,"failedJobsHistoryLimit": 1,"concurrencyPolicy": "Replace"}}'
done
done
