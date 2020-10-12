import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LogginComponent } from './component/loggin/loggin.component';
import { StatesComponent } from './component/states/states.component';


const routes: Routes = [
  {
    path:'loggin',
    component: LogginComponent
  },
  {
    path:'states',
    component: StatesComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
