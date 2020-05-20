docker build -t cooma/multi-client:latest -t cooma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cooma/multi-server:latest -t cooma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cooma/multi-worker:latest -t cooma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cooma/multi-client:latest
docker push cooma/multi-server:latest
docker push cooma/multi-worker:latest
docker push cooma/multi-client:$SHA
docker push cooma/multi-server:$SHA
docker push cooma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cooma/multi-server:$SHA
kubectl set image deployments/client-deployment client=cooma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cooma/multi-worker:$SHA

