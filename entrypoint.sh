#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

export namespace_arg=""
if [ "$3" != "" ]; then
    export namespace_arg="-n $3"
fi

result="$(kubectl $namespace_arg $1 -f $2)"

status=$?
echo ::set-output name=result::$result
echo "$result"
if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi
