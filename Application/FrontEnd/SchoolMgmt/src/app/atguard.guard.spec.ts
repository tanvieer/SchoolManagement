import { TestBed } from '@angular/core/testing';

import { ATGuardGuard } from './atguard.guard';

describe('ATGuardGuard', () => {
  let guard: ATGuardGuard;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    guard = TestBed.inject(ATGuardGuard);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });
});
