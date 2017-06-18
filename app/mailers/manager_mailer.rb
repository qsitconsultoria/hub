class ManagerMailer < ActionMailer::Base
  default from: 'quero@startae.com.br'

  def notify(manager)
    @manager = manager

    mail to: "@manager.name <#{@manager.email}>", subject: 'GIZ Hub: Você foi adicionado como gestor de uma unidade'
  end
end
