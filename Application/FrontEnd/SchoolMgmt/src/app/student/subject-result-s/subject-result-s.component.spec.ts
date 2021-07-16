import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SubjectResultSComponent } from './subject-result-s.component';

describe('SubjectResultSComponent', () => {
  let component: SubjectResultSComponent;
  let fixture: ComponentFixture<SubjectResultSComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SubjectResultSComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SubjectResultSComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
