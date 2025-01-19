public with sharing class EmailAprovacaoGestaoCarteira {
    public static void sendApprovalEmail(Id MovieId) {
        // Recupera o objeto Gestão de Carteira
        Movie__c movies = [SELECT
        Total_de_Avalia_es__c,
        Name,
        Studio__c,
        Or_amento__c,
        Media_das_Notas__c,
        Diretor__c,
        Diretor__r.Name,
        Diretor__r.Email

            FROM Movie__c WHERE Id = :MovieId];

        // Monta o corpo do e-mail
        if (movies.Diretor__r.Email != null){
        String emailBody = 'INFORMAÇÕES DO Movie: \n\n';
        emailBody += 'Nome do Movie: ' + movies.Name + '\n';
        emailBody += 'Média: ' + movies.Media_das_Notas__c + '\n';
        emailBody += 'Orçamento: ' + movies.Or_amento__c + '\n\n';
        
        emailBody += 'DADOS DO CLIENTE: \n\n';
        emailBody += 'Cliente: ' + movies.Diretor__r.Name + '\n';


        // Configura os detalhes do e-mail
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Aprovação de Fluxo: Desconto/Reparcelamento');
        mail.setToAddresses(new String[] {movies.Diretor__r.Email});
        mail.setPlainTextBody(emailBody);
        
        // Envia o e-mail
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
   }else { 
    System.debug('Email não enviado' + movies.Diretor__r.Email);
    
   }
 }
}