docker build -t jf971m/multi-client:latest -t jf971m/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jf971m/multi-server:latest -t jf971m/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jf971m/multi-worker:latest -t jf971m/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push jf971m/multi-client:latest 
docker push jf971m/multi-server:latest 
docker push jf971m/multi-worker:latest

docker push jf971m/multi-client:$SHA 
docker push jf971m/multi-server:$SHA 
docker push jf971m/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jf971m/multi-server:$SHA
kubectl set image deployments/client-deployment client=jf971m/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jf971m/multi-worker:$SHA
