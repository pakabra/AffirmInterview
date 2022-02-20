import { LightningElement ,wire,track,api} from 'lwc';
import getAccounts from '@salesforce/apex/LWCDemoController.getAccounts';
import getAccountDetails from '@salesforce/apex/LWCDemoController.getAccountDetails';

export default class LWCDemo extends LightningElement {
    @track columns=[
        {
        label: 'Id',
        fieldName: 'Id',
        type: 'text'
        },
        {
            label: 'Name',
            fieldName: 'Name',
            type: 'text'
        }
    ];
    @track records =[];
    @track accRecord=[];
    error;
    isDetailsViewEnabled = false;
    isDataTableEnabled = false;
    buttonLabel ='Next';
    selectedRow;
    isLoading = false;
    @wire(getAccounts)
    wiredAccounts({
        error,
        data
    }) {
        console.log('data=='+JSON.stringify(data));
        if (data) {
            this.records = data;
        } else if (error) {
            this.error = error;
        }
    }
    connectedCallback(){
        this.isDataTableEnabled=true;
    }
    handleRowSelection(event){
        var selectedRows=event.detail.selectedRows;
        if(selectedRows.length>1)
        {
            var el = this.template.querySelector('lightning-datatable');
            selectedRows=el.selectedRows=el.selectedRows.slice(1);
            this.selectedRow=selectedRows;
            event.preventDefault();
            return;
        }else{
            this.selectedRow=selectedRows[0].Id;
        }
    
    }

    handleClick(){
       if(this.buttonLabel =='Next' && this.selectedRow){
           this.isLoading=true;
           this.getAccountDetails();
        }else{
            this.isDataTableEnabled=true;
            this.isDetailsViewEnabled=false;
            this.buttonLabel = 'Next';
            this.isLoading=false;
        }
       
    }


    getAccountDetails(){
        getAccountDetails({
            recordId : this.selectedRow
        })
        .then((result,error) => {
            console.log('accRecord==='+JSON.stringify(result));
            if(result){
               this.accRecord =result;
               this.isDataTableEnabled=false;
               this.isDetailsViewEnabled=true;
               this.buttonLabel = 'Back';
                this.isLoading=false;
            }else{
                this.error=error;
                this.isLoading=false;
            }
        })
    }
   
}