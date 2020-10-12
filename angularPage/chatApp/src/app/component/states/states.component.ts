import { Component, OnInit } from '@angular/core';
import { States } from 'src/app/domain/states';
import { StatesService } from 'src/app/services/states.service';

@Component({
  selector: 'app-states',
  templateUrl: './states.component.html',
  styleUrls: ['./states.component.css']
})
export class StatesComponent implements OnInit {

  public stateList:States[];

  constructor(public stateService: StatesService) { }

  ngOnInit(): void {
    this.getStates();
  }

  getStates():void{
    this.stateService.getStates().subscribe(data=>{
      this.stateList = data;
    },error => {
      console.error('error de la chit : ' + error);
    });
  }

}
