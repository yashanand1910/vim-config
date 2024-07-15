git pull
git add .
git commit -m "Update config on $(date)"
git push

docker build -t ghcr.io/yashanand1910/dev -t yashanand1910/dev -t dev .
docker push ghcr.io/yashanand1910/dev:latest
docker system prune -f
