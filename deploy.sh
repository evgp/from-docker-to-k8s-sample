docker build -t eugocker/multi-client -f ./client/Dockerfile ./client
docker build -t eugocker/multi-server -f ./server/Dockerfile ./server
docker build -t eugocker/multi-worker -f ./worker/Dockerfile ./worker
docker push eugocker/multi-client
docker push eugocker/multi-server
docker push eugocker/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eugocker/multi-server # it must be latest version, so the uniq version setting is required!

