# Files to reproduce libostree deploy error in Docker

```
git clone https://github.com/oytis/ostree-docker-test
cd ostree-docker-test
docker build . -t ostree-test
docker run ostree-test
```

To make sure that it is commit `6063bdb0130cd0dc099bbf509f90863af7b3f0c0` that introduced the error change OSTREE\_REV in Dockerfile to `b669bcafe54479cf48d95293e18c5d0f3fe85ebc` (which is the one directly preceding the failing one) and repeat the procedure.
