docker build -t alvieira/fibonacci-multi-docker-client:latest -t alvieira/fibonacci-multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvieira/fibonacci-multi-docker-server:latest -t alvieira/fibonacci-multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t alvieira/fibonacci-multi-docker-worker:latest -t alvieira/fibonacci-multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alvieira/fibonacci-multi-docker-client:latest 
docker push alvieira/fibonacci-multi-docker-server:latest
docker push alvieira/fibonacci-multi-docker-worker:latest
docker push alvieira/fibonacci-multi-docker-client:$SHA 
docker push alvieira/fibonacci-multi-docker-server:$SHA
docker push alvieira/fibonacci-multi-docker-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alvieira/fibonacci-multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=alvieira/fibonacci-multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=alvieira/fibonacci-multi-docker-worker:$SHA

