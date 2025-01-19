public with sharing class EmailManagerTRAILHEAD {
    
        /*
        A EmailManagerclasse tem um método público ( sendMail()) que envia e-mail 
        e usa métodos Messaging integrados da biblioteca de classes Apex. Além disso
        , essa classe tem um método auxiliar privado ( inspectResults()), que 
        não pode ser chamado externamente porque é privado, mas é usado apenas 
        dentro da classe. Esse método auxiliar inspeciona os resultados da chamada de 
        envio de e-mail e é chamado por sendMail().
        */


        // ****METODO PUBLICO******//
        public void sendEmail(String address, String subject, String body) {
            //CRIE A MENSAGEM DE EMAIL DO OBJETO

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {address};
            mail.setToAddresses(toAddresses);
            mail.setSubject(subject);
            mail.setPlainTextBody(body);

            //Essa mensagem de email é realizada pelo metodo sen email

            Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                        new Messaging.SingleEmailMessage[] { mail });

                
            //esse  call o inspeciona os resultados da chamada de envio de e-mail 
            //e retorna true se a mensagem de e-mail for bem-sucedida. 
            inspectResults(results);      

    }

            //helper method
            private static Boolean inspectResults(Messaging.SendEmailResult[] results){
                Boolean sendResult = true;

                //sendEmail retorna a list de resultados do objeto
                //itera na lista de inspect results
                for (Messaging.SendEmailResult res : results){
                    if(res.isSuccess()){
                        System.debug('ENVIO DE EMAIL SUCESSO');


                    }
                    else {
                        sendResult = false;
                        System.debug('ENVIO DE EMAIL ERRO' + res.getErrors());
                    }
                }
                return sendResult;
            }
            /* COMO CHAMAR UM EMAIL NÃO ESTÁTICO

            EmailManager em = new EmailManager();
            em.sendMail('Your email address', 'Trailhead Tutorial', '123 body');



            Chamar um método estático


Como o método sendMail() em nossa classe não acessa variáveis membro da classe, não é necessário que ele seja um 
método de instância. Vamos alterá-lo para método estático adicionando a palavra-chave static a sua declaração. 
Os métodos estáticos são mais fáceis de chamar do que os métodos de instância porque eles não precisam ser chamados 
em uma instância da classe, mas são chamados diretamente no nome da classe.

No Developer Console, localize a guia aberta da classe EmailManager e modifique a primeira linha da definição do método 
sendMail() para o seguinte (a única alteração é a adição da palavra-chave static).

public static void sendMail(String address, String subject, String body) {

Clique em Arquivo | Salvar para salvar sua classe.
Modifique as instruções na janela Executar anônimo para chamar o método estático no nome da classe.

EmailManager.sendMail('Your email address', 'Trailhead Tutorial', '123 body');

Clique em Executar.Agora que este método foi executado, você pode verificar seu email e, opcionalmente, 
o log de depuração como nas etapas anteriores.



            */
}