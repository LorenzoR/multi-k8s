# Build images
docker build -t lrodrigo/multi-client:latest -t lrodrigo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lrodrigo/multi-server:latest -t lrodrigo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lrodrigo/multi-worker:latest -t lrodrigo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push images
docker push lrodrigo/multi-client:latest
docker push lrodrigo/multi-server:latest
docker push lrodrigo/multi-worker:latest

# Push with Git SHA tag
docker push lrodrigo/multi-client:$SHA
docker push lrodrigo/multi-server:$SHA
docker push lrodrigo/multi-worker:$SHA

# Apply config files
kubectl apply -f k8s

# Apply latest tags
kubectl set image deployments/server-deployment server=stephengrider/multi-server:latest
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:latest

#kubectl set image deployments/server-deployment server=lrodrigo/multi-server:$SHA
#kubectl set image deployments/client-deployment client=lrodrigo/multi-client:$SHA
#kubectl set image deployments/worker-deployment worker=lrodrigo/multi-worker:$SHA
