import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';
@Injectable({
  providedIn: 'root'
})
export class LogginService {

  public url = environment.baseUrlApi + 'logChat/';

  constructor(public httpClient : HttpClient) { }

  public loggin(email:String, password: String):Observable<any>{
    return this.httpClient.post(this.url, {
      email: email,
      password: password
    });
  }


}
