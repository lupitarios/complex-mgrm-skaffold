docker build -t m4r14r1os/complex-multi-client:latest -t m4r14r1os/complex-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t m4r14r1os/complex-multi-server:latest -t m4r14r1os/complex-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t m4r14r1os/complex-multi-worker:latest -t m4r14r1os/complex-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push m4r14r1os/complex-multi-client:latest
docker push m4r14r1os/complex-multi-server:latest
docker push m4r14r1os/complex-multi-worker:latest

docker push m4r14r1os/complex-multi-client:$SHA
docker push m4r14r1os/complex-multi-server:$SHA
docker push m4r14r1os/complex-multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=m4r14r1os/complex-multi-server:$SHA
kubectl set image deployments/client-deployment client=m4r14r1os/complex-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=m4r14r1os/complex-multi-worker:$SHA