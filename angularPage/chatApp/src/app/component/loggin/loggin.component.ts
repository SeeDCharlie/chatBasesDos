import { Component, OnInit } from '@angular/core';
import { UserLoggin } from 'src/app/domain/user-loggin';
import { LogginService } from 'src/app/services/loggin.service';

@Component({
  selector: 'app-loggin',
  templateUrl: './loggin.component.html',
  styleUrls: ['./loggin.component.css']
})

export class LogginComponent implements OnInit {

  public titulo: string = 'LoginChat';

  private dataResponse: UserLoggin;

  constructor(private logginService: LogginService) {

  }

  ngOnInit(): void {

  }

  logginAction(username:string, password:string){
      console.log("datos ingresados : " + username + "  " + password);
      this.logginService.loggin(username, password).subscribe(
        data => {
          this.dataResponse = data;
          console.log("Bienvenido" + this.dataResponse.usuario.email);
        },
        error => {
          console.error('Error Al Loguearse' + error);
        });
  }

}
