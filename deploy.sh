docker build -t eugocker/multi-client:latest -t eugocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eugocker/multi-server:latest -t eugocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eugocker/multi-worker:latest -t eugocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eugocker/multi-client:latest
docker push eugocker/multi-server:latest
docker push eugocker/multi-worker:latest
docker push eugocker/multi-client:$SHA
docker push eugocker/multi-server:$SHA
docker push eugocker/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eugocker/multi-server:$SHA # it must be latest version, so the uniq version setting is required!
kubectl set image deployments/client-deployment client=eugocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eugocker/multi-worker:$SHA
