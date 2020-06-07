docker build -t gileyni/multi-client:latest -t gileyni/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t gileyni/multi-server:latest -t gileyni/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t gileyni/multi-worker:latest -t gileyni/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push gileyni/multi-client:latest
docker push gileyni/multi-server:latest
docker push gileyni/multi-worker:latest

docker push gileyni/multi-client:$GIT_SHA
docker push gileyni/multi-server:$GIT_SHA
docker push gileyni/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=gileyni/multi-client:$GIT_SHA
kubectl set image deployment/server-deployment client=gileyni/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment client=gileyni/multi-worker:$GIT_SHA