docker build -t sanduljayathileka/multi-client:latest -t sanduljayathileka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanduljayathileka/multi-server:latest -t sanduljayathileka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanduljayathileka/multi-worker:latest -t sanduljayathileka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sanduljayathileka/multi-client:latest
docker push sanduljayathileka/multi-server:latest
docker push sanduljayathileka/multi-worker:latest

docker push sanduljayathileka/multi-client:$SHA
docker push sanduljayathileka/multi-server:$SHA
docker push sanduljayathileka/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployment/server-deployment server=sanduljayathileka/multi-server:$SHA
kubectl set image deployment/client-deployment client=sanduljayathileka/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=sanduljayathileka/multi-worker:$SHA