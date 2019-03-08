docker build -t suhelkhan/multi-client:latest -t suhelkhan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t suhelkhan/multi-server:latest -t suhelkhan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t suhelkhan/multi-worker:latest -t suhelkhan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push suhelkhan/multi-client:latest
docker push suhelkhan/multi-server:latest
docker push suhelkhan/multi-worker:latest

docker push suhelkhan/multi-client:$SHA
docker push suhelkhan/multi-server:$SHA
docker push suhelkhan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=suhelkhan/multi-server:$SHA
kubectl set image deployments/client-deployment client=suhelkhan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=suhelkhan/multi-worker:$SHA