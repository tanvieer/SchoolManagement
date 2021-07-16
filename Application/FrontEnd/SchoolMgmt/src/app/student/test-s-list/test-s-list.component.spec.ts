import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TestSListComponent } from './test-s-list.component';

describe('TestSListComponent', () => {
  let component: TestSListComponent;
  let fixture: ComponentFixture<TestSListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TestSListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TestSListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
