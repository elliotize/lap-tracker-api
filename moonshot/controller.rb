require_relative 'x11_ssh_command_builder'
module Moonshot
  class Controller
    def x11_ssh
      run_plugins(:pre_ssh)
      @config.ssh_instance ||= SSHTargetSelector.new(
        stack, asg_name: @config.ssh_auto_scaling_group_name).choose!
      cb = X11SSHCommandBuilder.new(@config.ssh_config, @config.ssh_instance)
      result = cb.build(@config.ssh_command)

      warn "Opening SSH connection to #{@config.ssh_instance} (#{result.ip})..."
      exec(result.cmd)
    end
  end
end
