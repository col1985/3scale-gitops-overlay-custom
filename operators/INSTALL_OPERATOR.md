# Installing 3-Scale using the operator and oc

## Check for 3Scale Operator in Cluster

```bash
oc get packagemanifests | grep 3scale-operator
```

## Get Channel and currentCSV props

```bash
oc get packagemanifests 3scale-operator -o \
jsonpath="{range .status.channels[*]}Channel: {.name} currentCSV: {.currentCSV}{'\n'}{end}"
```

## Get the catalog Source

```bash
oc get packagemanifests 3scale-operator -o jsonpath={.status.catalogSource} ; echo
```

## Get Catalog Namespace

```bash
oc get packagemanifests 3scale-operator -o jsonpath={.status.catalogSourceNamespace} ; echo
```

## Create 3Scale subscription, install for all namespaces

```bash
oc apply -f 3scale-operator.yaml
```

## Check if install plan should be approved

```bash
oc get installplan -n openshift-operators
```

## Approve install plan using patch

Note: installplan-name below is retrived from get install plan command.

```bash
oc patch installplan <installplan-name> -n openshift-operators \
--type merge --patch '{"spec":{"approved":true}}'
```

## 3scale 2.14 subscription

```bash
# operator.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: 3scale
  namespace: openshift-operators
spec:
  channel: threescale-2.14
  installPlanApproval: Automatic
  name: 3scale-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: 3scale-operator.v0.11.12
```

## 3scale 2.15 subscription

```bash
# operator.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: 3scale
  namespace: openshift-operators
spec:
  channel: threescale-2.15
  installPlanApproval: Automatic
  name: 3scale-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: 3scale-operator.v0.12.0
```
