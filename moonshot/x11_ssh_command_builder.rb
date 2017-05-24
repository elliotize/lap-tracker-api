module Moonshot
  class X11SSHCommandBuilder < SSHCommandBuilder
    def build(command = nil)
      cmd = ['ssh', '-t']
      cmd << '-X'
      cmd << "-i #{@config.ssh_identity_file}" if @config.ssh_identity_file
      cmd << "-l #{@config.ssh_user}" if @config.ssh_user
      cmd << instance_ip
      cmd << Shellwords.escape(command) if command
      Result.new(cmd.join(' '), instance_ip)
    end
  end
end
