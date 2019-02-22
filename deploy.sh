docker build -t jasonchi/multi-client:latest -t jasonchi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jasonchi/multi-server:latest -t jasonchi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jasonchi/multi-worker:latest -t jasonchi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jasonchi/multi-client:latest
docker push jasonchi/multi-server:latest
docker push jasonchi/multi-worker:latest
docker push jasonchi/multi-client:$SHA
docker push jasonchi/multi-server:$SHA
docker push jasonchi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jasonchi/multi-server:$SHA
kubectl set image deployemnts/client-deployment client=jasonchi/multi-client:$SHA
kubectl set image deployemnts/worker-deployemnt worker=jasonchi/multi-worker:$SHA
