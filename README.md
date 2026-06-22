# test_for_hiringband


# deploy

push pr pull to dev branch -> execute manually release in GHA. -> Pick created workflow and press workflow to run\finish


# Rollback

Just pick needed tagged worflow, attached to needed commit and redeploy it.


# Monitoring

For now -> was sacrificed -> But can be easily added with grafana prometheus stack or CloudWatch.


# Terragrunt (Needs to be added infra versioning with commit specify)

Login into environment folder -> terragrunt plan -> terragrunt apply

--backend-init might be added to initialize backend

need to unite ecr repo for envs

# Accectence criterias

[+] reviewer can follow README and run/simulate deployment locally or in a sandbox;

[-] helm values clearly separate dev and stage;

[+] rollback path is documented and realistic;

[-] alerts are tied to actual failure modes (not generic placeholders).

[+] policy-as-code or linting checks;

[-] preview environment strategy;
 
 Need to integrate tf into pipeline

[+-] release checklist template.

automated via bash, for rollback-deploy ease purpose.
