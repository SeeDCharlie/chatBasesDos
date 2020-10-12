import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StatesService {

  public url:string = 'http://127.0.0.1:8000/api/estados/';

  constructor(public HttpClient: HttpClient) { }

  public getStates():Observable<any>{
    return this.HttpClient.get(this.url);
  }


}
