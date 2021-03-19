# Production Readiness Checklist: matchmaker_rails

_Version 1.1_

The [Production Readiness](https://github.com/ezcater/production-readiness) project is a collection of materials and processes that help Squads ensure that they are following ezcater's best practices for operating services in production, with the end goal of improving availability, sharing operational knowledge, and providing visibility into the overall health of the microservice ecosystem.

This checklist represents a snapshot-in-time picture of the production readiness of this service. The items act as guidelines to help Squads ensure they are doing everything they can to improve a service's availability. There is no requirement that a service check every box prior to production deployment. Instead, 100% completion should be treated as an ideal to strive for.

### Getting Started

1.  Copy the most recent version of the Checklist Template to a file named `production-readiness.md` at the root of the repository. Commit the unmodified file so that just the changes are included in follow-up PRs.

2.  Add the following line to the bottom of the repository's `CODEOWNERS` file to ensure that SRE's get notified when the checklist is updated:

        production-readiness.md @ezcater/sre

3.  Perform an initial review by comparing the current state of the service to the items in the checklist. This can be done independently by the Squad or in conjunction with a member of the SRE team in a [Production Readiness Review](https://github.com/ezcater/production-readiness#production-readiness-reviews). Since the review process is still manual, it is understood that some items may become stale over time. As the [Production Readiness](https://github.com/ezcater/production-readiness#processes) process matures, the plan is to add automation where possible to help keep things current.

4.  Periodically perform follow-up reviews in order to capture changes in the service's production readiness. Periodic reviews are recommended every 3 to 6 months.

### Reviews

| Date | Reviewers |
| ---- | --------- |
|      |           |

## Stability and Reliability

### The Development Cycle

**Does the service have a central repository where all code is stored?**

-   [ ] The service has it's own dedicated Github repository under the ezcater organization
-   [ ] The repository follows ezCater's [application/package naming conventions](https://ezcater.atlassian.net/wiki/spaces/POL/pages/681379094/Application+and+Package+Naming)
-   [ ] The "master" branch is set as protected in Github and does not allow force pushes or being deleted
-   [ ] The GitHub "Collaborators and Teams" settings are as follows:

    -   The "CI" Team has Write
    -   One or more ezCater Teams (such as "Devs") has Admin or Write
    -   There are no Collaborators
    -   Optionally, data-warehouse and read-only-services may have Read
    -   Any exceptions are understood and documented.

**Do developers work in a development environment that accurately reflects the state of production (e.g., that accurately reflects the real world)?**

-   [x] Programming language versions are pinned in the repository (ie. .ruby-version or specified in Gemfile)
-   [x] Code dependencies are versioned and locked (ie. Bundler, npm)
-   [ ] Local software dependencies such as databases and key-value stores are specified and match the versions in production (ie. READMEs, docker-compose.yml)

**Are there appropriate lint, unit, integration, and end-to-end tests in place for the service?**

-   [x] Some sort of lint tool is configured (ie. Rubocop)
-   [ ] Unit and Integration tests exist (ie. Rspec)
-   [ ] Code Climate is enabled

**Is there a strict separation of config from code?**

-   [ ] All configuration values (including all sensitive values) are read from environment variables at runtime
-   [ ] A default set of development values are provided with the repository (ie. in a .env file)

**Are there code review procedures and policies in place?**

-   [ ] All developers on the team are aware of and follow ezCater's [Pull Request Playbook](https://github.com/ezcater/pull-request-playbook/blob/master/pull_request_playbook.md)

**Is the test, packaging, build, and release process automated?**

-   [x] Builds trigger on each release and require lint, unit, and integration tests to pass
-   [x] A Dockerfile exists and includes all necessary software for the app to run properly in production
-   [x] The Dockerfile makes use of an ezCater managed base image instead of a public image
-   [x] The ezCater managed base image is the latest possible version
-   [x] The base image should match the correct software versions in use (ie. Ruby-Postgres matrix for the ruby Docker image)
-   [x] A service.yml file exists
-   [ ] Code is pushed to production after successful builds

See the [How to deploy into production from scratch](https://ezcater.atlassian.net/wiki/spaces/POL/pages/436371641/New+Skyline+Applications+How+to+deploy+into+production+from+scratch) docs for more info on how to set the above up.

### The Deployment Pipeline

**Does the microservice ecosystem have a standardized deployment pipeline?**

-   [x] A Jenkinsfile exists and makes use of the latest version of the ezcaterPipeline
-   [ ] Any deployment related commands, such as migrations, are defined as jobs in service.yml (no manual steps)

See the [How to deploy into production from scratch](https://ezcater.atlassian.net/wiki/spaces/POL/pages/436371641/New+Skyline+Applications+How+to+deploy+into+production+from+scratch) docs for more info on how to set the above up.

**Does the service have a staging environment where changes are deployed first prior to production?**

-   [ ] The service has a fully-functioning staging environment
-   [ ] The staging environment is set to continuously deploy off the "master" branch

**Does the service have a sandbox environment that can be used for exploratory testing of changes?**

-   [ ] The service has a fully-functioning sandbox environment
-   [ ] Developers are able to deploy arbitrary versions of the service to the sandbox environment

**What access do the staging and sandbox environments have to production services?**

-   [ ] The staging environment does not access production services, but instead makes use of other staging services
-   [ ] The sandbox environment does not access production services, but instead makes use of other sandbox services

**Are all deployment environments identical to production?**

-   [ ] All deployment environments use matching backing service versions (databases, key value stores, etc.)
-   [x] For any particular version of the service, the same build artifacts (Docker images) are deployed to each environment

**Are configs set appropriately?**

-   [ ] All required environment variables are set in each deployment environment
-   [ ] All deployment environments use different values for sensitive configs (ie. SECRET_KEY_BASE)

**Is there a procedure in place for skipping the staging phase in case of an emergency?**

-   [ ] Everyone on the team knows how to trigger deployments manually (either using the [Jenkins UI](http://jenkins.ezcater.net) or [jenkins_runner](https://github.com/ezcater/jenkins_runner) gem)

### Dependencies

**Are the service's dependencies known?**

This section lists all the other services this service depends on to function
properly. This includes self-hosted backing services (ie. PostgreSQL), internal
ezCater services (ie. Identity), and external 3rd party services (ie. Sendgrid).

| Dependency | Internal or Third Party Service? | How is it used? | Point of Contact | Approximate SLA | How does a failure affect the service? |
| ---------- | -------------------------------- | --------------- | ---------------- | --------------- | -------------------------------------- |
|            |                                  |                 |                  |                 |                                        |
|            |                                  |                 |                  |                 |                                        |

**Are the service's clients known?**

This section lists all the other services that make use of this service. This
includes internal ezCater services as well as any external 3rd party services.

| Client | How is it used? | Point of Contact | How does a failure affect the service? |
| ------ | --------------- | ---------------- | -------------------------------------- |
|        |                 |                  |                                        |
|        |                 |                  |                                        |
|        |                 |                  |                                        |

### Routing and Discovery

**Are healthchecks set to detect unhealthy processes and prevent them from receiving requests?**

-   [x] Healthchecks are specified for all web process types in service.yml

**Are all production public DNS records properly provisioned and monitored?**

| Hostname | SRE Provisioned | Datadog Synthetic Monitor |
| -------- | --------------- | ------------------------- |
|          |                 |                           |
|          |                 |                           |
|          |                 |                           |

**Are all production internal DNS records properly provisioned and monitored?**

| Hostname | SRE Provisioned |
| -------- | --------------- |
|          |                 |
|          |                 |
|          |                 |

**Are calls to internal services communicating directly over the private network?**

-   [ ] When possible, internal DNS hostnames are used for service-to-service communication

## Scalability and Performance

### Knowing the Growth Scale

**What is this service’s qualitative growth scale?**

The qualitative growth scale describes the scalability of a service in relation
to higher-level business metrics. A service may, for example, scale with
the number of users, with the number of people who open a phone application
(“ eyeballs”), or with the number of orders (for a food delivery service).

EXAMPLE:

The business metric(s) that drive the scalability of the service are:

-   Number of users

Growth Projections:

| Date       | Projected Growth |
| ---------- | ---------------- |
| Current    | 15 users         |
| 10/1/2020  | 40 users         |
| 12/31/2020 | 80 users         |

**What is this service’s quantitative growth scale?**

The quantitative growth scale is defined by translating the qualitative growth scale into a measurable quantity. For example, if the qualitative growth scale of our service is measured in “eyeballs” (e.g., how many people open a phone application), and each “eyeball” results in two requests to our service and one database transaction, then our quantitative growth scale is measured in terms of requests and transactions, resulting in requests per second and transactions per second as the two key quantities determining our scalability.

EXAMPLE:

The qualitative metric(s) listed above translate into the following measurable quantities:

-   Each user translates to an average 10 Requests per minute

Growth Projections:

| Date       | Projected Growth            |
| ---------- | --------------------------- |
| Current    | 15 users x 10 RPM = 150 RPM |
| 10/1/2020  | 40 users x 10 RPM = 400 RPM |
| 12/31/2020 | 80 users x 10 RPM = 800 RPM |

### Resource Awareness

[DataDog](https://datadoghq.com) is a great place to look and see a service's current resource usage.

**Are requests/limits set for system resources?**

-   [ ] CPU requests/limits are set in `service.yml` for process types that consume over 250 mcores
-   [ ] Memory requests/limits are set in `service.yml` for any process types that consume over 256Mi of memory

**Is the service making efficient use of its resources?**

-   [ ] Actual production processes are using a significant portion of the CPU and/or Memory requests defined in `service.yml`

### Dependency Scaling

The table below should include a line for each dependency listed in the "Dependencies" section.

| Dependency\* | At what point will this service outgrow the dependency? | How long until this point is reached | Are the dependency's owners aware of this timeline? |
| ------------ | ------------------------------------------------------- | ------------------------------------ | --------------------------------------------------- |
|              |                                                         |                                      |                                                     |
|              |                                                         |                                      |                                                     |
|              |                                                         |                                      |                                                     |

## Monitoring

### Key Operating Metrics

The purpose of this section is to document which business metrics are important
to the operation of the service. Which metrics would tell you, at a glance, if the service is performing
as expected.

**What are the service's key operating metrics?**

EXAMPLE:

Note: These metrics will probably be very specific to this service, unlike the
system-level metrics which will be usually be the same across all services.

| Metric                                    | Description                                      | Acceptable Value Range | How is the Team Alerted of Abnormal Values? | Resolution steps or link to runbook |
| ----------------------------------------- | ------------------------------------------------ | ---------------------- | ------------------------------------------- | ----------------------------------- |
| Total count of 3rd party orders requested | How many orders were submitted                   |                        |                                             |                                     |
| Successful orders                         | How many orders were successful                  |                        |                                             |                                     |
| Failed orders                             | How many orders failed                           |                        |                                             |                                     |
| Average order fulfillment duration        | Average of how long it takes to fulfill an order |                        |                                             |                                     |

**Are all the service's key operating metrics monitored?**

-   [ ] All of the above key operating metrics are available in DataDog
-   [ ] All of the above key operating metrics alert on abnormal values

### Key System-Level Metrics

The purpose of this section is to document which system-level metrics are important to
the operation of the service. Which metrics would tell you, at a glance, if the
service is performing as expected.

**What are the service's system-level metrics?**

| Metric                     | Description                                                                                    | Acceptable Value Range            | How is the Team Alerted of Abnormal Values? |
| -------------------------- | ---------------------------------------------------------------------------------------------- | --------------------------------- | ------------------------------------------- |
| CPU Usage per container    | How much CPU containers are using as a percentage of the requested CPU for the container       | &lt;80% of limit in `service.yml` |                                             |
| Memory Usage per container | How much memory containers are using as a percentage of the requested memory for the container | &lt;80% of limit in `service.yml` |                                             |
| Throughput                 | How many requests are being made to the service                                                | 100-1500 RPM                      |                                             |
| Error rate                 | How many requests to the service fail                                                          | &lt;5 RPM                         |                                             |
| Response Time              | How long requests take                                                                         | &lt;250 ms                        |                                             |

**Are all the service’s system-level metrics monitored?**

-   [ ] CPU and Memory metrics are available in DataDog
-   [ ] CPU and Memory metrics alert on abnormal values
-   [ ] Service has been added to Datadog APM
-   [ ] A Datadog monitor is set up with conditions for abnormal throughput, error rate, and response time values

### Logging

**Does this service log all important requests?**

-   [ ] All logs are sent to STDOUT/STDERR
-   [ ] Logs are sent with the appropriate severity level
-   [ ] Logs are formatted as JSON
-   [ ] Logs which include end user IP addresses use the real IP address, not internal or proxy IP addresses (ie. X-Forwarded-For HTTP header value)
-   [x] Logs are tagged with the appropriate application and role (_enabled by default in Skyline_)

**Are developers and SRE's able to quickly find important information?**

-   [ ] All developers on the team have access to Sumo Logic
-   [ ] When applicable, saved searches have been created in Sumo Logic to find commonly searched for logs

### Dashboards

**Does this service have a dashboard?**

-   [ ] An "App Dashboard" exists in DataDog
-   [ ] The "App Dashboard" includes all of the above key operating metrics
-   [ ] The "App Dashboard" includes all of the above system-level metrics
-   [ ] It can be determined if the service is working correctly by looking at the dashboard

### On-Call Rotations

**Is there a dedicated on-call rotation responsible for monitoring this service?**

-   [ ] A VictorOps schedule exists for this service's team
-   [ ] All team members participating on on-call are set up in VictorOps
-   [ ] The schedule has at least two developers on each shift (primary and backup)
