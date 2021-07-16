import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImportGradesComponent } from './import-grades.component';

describe('ImportGradesComponent', () => {
  let component: ImportGradesComponent;
  let fixture: ComponentFixture<ImportGradesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ImportGradesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ImportGradesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
