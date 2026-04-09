# DR Runbook (Quick Version)

## Goal
Fail over app traffic from primary region to secondary region with minimal downtime.

## Preconditions

- Both EKS clusters healthy
- ArgoCD apps synced in both clusters
- Secondary deployment has ready pods
- Route53 failover records are configured

## Drill steps

1. Confirm baseline:
   - app reachable
   - primary serving traffic
2. Simulate outage in primary:
   - scale app to zero in primary
3. Observe:
   - Route53 health check fails for primary
   - traffic shifts to secondary
4. Verify user impact:
   - check app response and region marker
5. Recovery:
   - restore primary replicas
   - validate health checks green

## Success criteria

- Failover works without manual DNS edits
- Secondary serves traffic during simulated outage
- Primary recovers cleanly after rollback
