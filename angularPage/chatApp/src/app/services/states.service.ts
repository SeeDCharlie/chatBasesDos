import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class StatesService {

  public url:string = environment.baseUrlApi + 'estados/';

  constructor(public httpClient: HttpClient) { }

  public getStates():Observable<any>{
    return this.httpClient.get(this.url);
  }


}
