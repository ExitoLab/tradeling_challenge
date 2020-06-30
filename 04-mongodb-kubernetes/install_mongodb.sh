helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm install mongo-replica stable/mongodb-replicaset -f values.yaml