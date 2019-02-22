docker build -t jasonchi38/multi-client:latest -t jasonchi38/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jasonchi38/multi-server:latest -t jasonchi38/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jasonchi38/multi-worker:latest -t jasonchi38/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jasonchi38/multi-client:latest
docker push jasonchi38/multi-server:latest
docker push jasonchi38/multi-worker:latest
docker push jasonchi38/multi-client:$SHA
docker push jasonchi38/multi-server:$SHA
docker push jasonchi38/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jasonchi38/multi-server:$SHA
kubectl set image deployemnts/client-deployment client=jasonchi38/multi-client:$SHA
kubectl set image deployemnts/worker-deployemnt worker=jasonchi38/multi-worker:$SHA
