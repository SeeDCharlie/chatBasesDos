import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { LoginResponse } from '../others/interfaces';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private _http: HttpClient) { 
    
      
  }

  api_ur = 'http://192.168.1.56:8000/'

  login(userame: string, passw: string): Observable<LoginResponse>{

    return this._http.post<LoginResponse>('${this.api_url}/api/logChat', {
      username : userame,
      passw : passw
    })

  }

}
