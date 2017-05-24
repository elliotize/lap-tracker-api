require_relative '../controller'
class IEX < Moonshot::SSHCommand
  self.description = 'Enter iex'
  def execute
    controller.config.ssh_command = "iex --erl '-smp enable' --name debug@$(hostname -I) --cookie 123"
    controller.ssh
  end
end
