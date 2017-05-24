require_relative '../controller'
class Observer < Moonshot::SSHCommand
  self.description = 'Enter observer'
  def execute
    controller.config.ssh_command = "iex --erl '-smp enable' --name debug@$(hostname -I) --cookie 123 -e :observer.start"
    controller.x11_ssh
  end
end
