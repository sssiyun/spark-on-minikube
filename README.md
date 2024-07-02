# spark-on-minikube
This is a demo to deploy spark applications with minikube

## Getting Started
Please ensure you have installed docker and minikube.

Start kubernetes cluster
```
minicube start
```
Start kubernetes UI dashboard
```
minicube dashboard
```
Test if run successfully ```http://<your-host>:<your-port>/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/```
## Start Spark Service
Build Hadoop and Spark image
```
eval $(minikube -p minikube docker-env)

docker build -t hadoop-spark-cluster:3.4.3 .
```
Deploy Spark master and Spark workers
```
kubectl create -f ./kubernetes/spark-master-deployment.yaml

kubectl create -f ./kubernetes/spark-master-service.yaml

kubectl create -f ./kubernetes/spark-worker-deployment.yaml

minikube addons enable ingress

kubectl apply -f ./kubernetes/minikube-ingress.yaml
```
Put forward spark master port
```
kubectl port-forward svc/spark-master 8080:8080
```
Test if run successfully http://localhost:8080
## Test Spark Script
Build Demo Spark Image 
```
cd demo-script

eval $(minikube -p minikube docker-env)

docker build -t spark-job:latest .
```
Submit Spark Job
```
kubectl apply -f spark-submit-pod.yaml
```
Check log
```
kubectl logs -f spark-submit-pod
```