# 在宿主机上执行
sudo docker run -d --name lyrio-judge \
  --network="host" \
  --privileged \
  --restart unless-stopped \
  -v /home/ysu/lyrio-judge:/workspace \
  -v /home/ysu/judge:/home/ysu/judge \
  -v /opt/rootfs-ng:/opt/rootfs-ng \
  -v /tmp/judge:/tmp/judge \
  -w /workspace \
  -e LYRIO_JUDGE_CONFIG_FILE=/workspace/config.yaml \
  lyrio-judge:latest \
  bash -c 'source /opt/rh/gcc-toolset-9/enable && yarn start'
