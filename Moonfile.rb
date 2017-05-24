APP_NAME = 'phoenix-service'

Moonshot.config do |m|
  m.app_name = APP_NAME
  m.environment_name = 'dev'
  m.artifact_repository = S3Bucket.new(APP_NAME)
  m.build_mechanism = Script.new('moonshot/bin/build.sh')
  m.deployment_mechanism = CodeDeploy.new(asg: 'AutoScalingGroup')
end
