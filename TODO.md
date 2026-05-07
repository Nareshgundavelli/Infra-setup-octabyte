# TODO: Fix CI/CD SSH Auth Error

## Infrastructure Details (Retrieved 2026-05-07):
- **EC2 Public IP:** 13.233.97.156
- **RDS Endpoint:** my-postgres-db.cnkkua2ykiim.ap-south-1.rds.amazonaws.com
- **ALB DNS Name:** octa-alb-170037906.ap-south-1.elb.amazonaws.com

## Steps:
- [x] Step 1: Update .github/workflows/cicd.yaml with debug, latest action version, improved script.
- [x] Step 1b: Align backend port (5000) and DB credentials across code and CI/CD.
- [ ] Step 2: Verify GitHub secrets (EC2_HOST, EC2_SSH_KEY, AWS creds).
    - *Note: EC2_HOST should be updated to 13.233.97.156*
- [ ] Step 3: EC2 server setup (public key, Docker/AWS CLI, SG).
- [ ] Step 4: Test pipeline via GitHub push/PR.
- [ ] Step 5: Monitor deploy, health checks.
- [ ] Complete: Remove TODO.md

Current: Ready for Step 2.
