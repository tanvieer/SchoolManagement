import { TucClass } from 'src/app/shared/models/tuc-class.model';
import { OtherService } from './../../shared/other.service';
import { Component, OnInit } from '@angular/core'; 
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-class-list',
  templateUrl: './class-list.component.html',
  styleUrls: ['./class-list.component.css']
})
export class ClassListComponent implements OnInit {

  public classList: TucClass[] = [];
  public collectionSize : number = 0;
  constructor(public service: OtherService,
    private toastr : ToastrService ) { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData () {
    this.classList = [];
    this.service.getClassList()
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Class List');
      }  
    });
  }


  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.collectionSize = jsonData.length;
    for (let i = 0; i < this.collectionSize; i++) {
      const data = new TucClass();
      data.Index = i+1; 
      data.ClassId  = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName;       
      this.classList.push(data);
    } 
    //this.refreshTeachers();
  }
   

  onDelete(id:string){
      if(confirm("Are you sure to delete this class?")) { 

        this.service.deleteClass(id)
        .subscribe((data: any) => {  
          if(data.Status == "SUCCESS"){
            this.toastr.success(data.Message, 'Delete Class');
            this.loadData();
          }
          else {
            this.toastr.error(data.Message, 'Delete Class');
          } ;
        });
      }
  }

}
