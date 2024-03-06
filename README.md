# oai-integration-master

## OAI 5G CN deployment

[OAI 문서](https://gitlab.eurecom.fr/oai/cn5g/oai-cn5g-fed/-/blob/master/docs/DEPLOY_HOME.md?ref_type=heads)를 바탕으로 구축.

0. Pre-requisites
	- Vagrant
	- VirtualBox

1. Repository Clone

```
$ git clone https://github.com/asungajinli/oai-integration-master.git
```

2. Vagrant 실행

```
$ cd oai-integration-master/oai5gcn
$ vagrant up
$ vagrant ssh
```

3. Deployment

[deployment.sh](/oai5gcn/deployment.sh) 참고
