/* 

Código de exemplo
Um cenário comum é pegar alguns conjuntos de registros sObject, executar algum processamento,
 como fazer um callout para um ponto de extremidade REST externo ou realizar alguns cálculos 
 e então atualizá-los no banco de dados de forma assíncrona. Como os métodos @future são limitados
  a tipos de dados primitivos (ou matrizes ou coleções de dados primitivos), o Apex que permite a 
  execução em fila é a opção ideal. O código a seguir pega uma coleção de registros de Conta, define
   a parentId para cada registro, e então atualiza os registros no banco de dados.

*/

public class UpdateParentAccount implements Queueable {
    private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext context) {
        for (Account account : accounts) {
          account.parentId = parent;
          // perform other processing or callout
        }
        update accounts;
    }
}

/*
Para adicionar esta classe como um trabalho na fila, execute o seguinte código:

// find all accounts in ‘NY’
List<Account> accounts = [select id from account where billingstate = ‘NY’];
// find a specific parent account for all records
Id parentId = [select id from account where name = 'ACME Corp'][0].Id;
// instantiate a new instance of the Queueable class
UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
// enqueue the job for processing
ID jobID = System.enqueueJob(updateJob);


Após enviar sua classe que permite a execução em fila para a execução, o trabalho 
será adicionado à fila e processado quando os recursos do sistema se tornarem disponíveis.
Você pode usar o novo ID para monitorar o progresso por meio da página de Trabalhos 
do Apex ou, programaticamente, consultando AsyncApexJob:

SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID


*/