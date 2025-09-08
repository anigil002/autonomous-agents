# Enhanced Testing Commands

## Testing Commands
Comprehensive slash commands for intelligent test orchestration and quality assurance.

### Core Testing Commands

#### /test-full
Execute complete testing suite with comprehensive reporting.

**Usage**: `/test-full`
**Description**: Orchestrates complete testing suite including unit, integration, E2E, visual regression, performance, and security tests with detailed reporting.

**Implementation**:
```javascript
export const testFull = {
  name: 'test-full',
  description: 'Execute comprehensive testing suite',
  parameters: [],
  handler: async () => {
    const testOrchestrator = await getAgent('autonomous-testing-orchestrator');
    return await testOrchestrator.executeFullSuite({
      includeUnit: true,
      includeIntegration: true,
      includeE2E: true,
      includeVisualRegression: true,
      includePerformance: true,
      includeSecurity: true,
      generateReport: true,
      parallel: true
    });
  }
};
```

#### /test-unit
Run unit tests with intelligent test selection.

**Usage**: `/test-unit [--watch] [--coverage]`
**Description**: Executes unit tests with smart test selection based on code changes, optional watch mode, and coverage reporting.

**Implementation**:
```javascript
export const testUnit = {
  name: 'test-unit',
  description: 'Execute unit tests with smart selection',
  parameters: ['options'],
  handler: async (options = {}) => {
    const testOrchestrator = await getAgent('autonomous-testing-orchestrator');
    return await testOrchestrator.executeUnitTests({
      smartSelection: true,
      watchMode: options.includes('--watch'),
      coverage: options.includes('--coverage'),
      parallel: true
    });
  }
};
```

#### /test-integration
Run integration tests with service dependency management.

**Usage**: `/test-integration [--services=api,database]`
**Description**: Executes integration tests with automatic service dependency setup and teardown.

#### /test-e2e
Execute end-to-end tests with browser automation.

**Usage**: `/test-e2e [--browser=chrome] [--headless]`
**Description**: Runs comprehensive end-to-end tests using Puppeteer with configurable browser options and screenshot capture.

#### /test-visual
Run visual regression tests with baseline management.

**Usage**: `/test-visual [--update-baselines]`
**Description**: Executes visual regression tests comparing current UI against established baselines with options to update baselines.

### Performance Testing Commands

#### /test-performance
Execute comprehensive performance testing suite.

**Usage**: `/test-performance [--load-pattern=gradual]`
**Description**: Runs performance tests including load testing, stress testing, and resource utilization monitoring.

**Implementation**:
```javascript
export const testPerformance = {
  name: 'test-performance',
  description: 'Execute performance testing suite',
  parameters: ['loadPattern'],
  handler: async (loadPattern = 'gradual') => {
    const testOrchestrator = await getAgent('autonomous-testing-orchestrator');
    return await testOrchestrator.executePerformanceTests({
      loadPattern,
      includeLoadTesting: true,
      includeStressTesting: true,
      includeEnduranceTesting: true,
      monitorResources: true,
      generateBenchmarks: true
    });
  }
};
```

#### /test-load
Run load testing scenarios with realistic traffic patterns.

**Usage**: `/test-load [--users=100] [--duration=5m]`
**Description**: Executes load testing with configurable user count and duration, simulating realistic traffic patterns.

#### /test-stress
Execute stress testing to find system breaking points.

**Usage**: `/test-stress [--max-users=1000]`
**Description**: Runs stress tests to identify system limits and failure points under extreme load conditions.

#### /test-benchmark
Run benchmark comparisons against previous versions.

**Usage**: `/test-benchmark [--baseline=v1.2.0]`
**Description**: Executes performance benchmarks and compares against specified baseline or previous version.

### Security Testing Commands

#### /test-security
Run comprehensive security testing suite.

**Usage**: `/test-security [--level=comprehensive]`
**Description**: Executes security testing including vulnerability scanning, penetration testing, and compliance validation.

**Implementation**:
```javascript
export const testSecurity = {
  name: 'test-security',
  description: 'Execute security testing suite',
  parameters: ['level'],
  handler: async (level = 'standard') => {
    const testOrchestrator = await getAgent('autonomous-testing-orchestrator');
    return await testOrchestrator.executeSecurityTests({
      level,
      includeVulnerabilityScanning: true,
      includeAuthenticationTesting: true,
      includeInputValidation: true,
      includeApiSecurity: true,
      generateSecurityReport: true
    });
  }
};
```

#### /test-vulnerabilities
Scan for security vulnerabilities in code and dependencies.

**Usage**: `/test-vulnerabilities [--severity=high]`
**Description**: Scans codebase and dependencies for security vulnerabilities with configurable severity filtering.

#### /test-auth
Test authentication and authorization flows.

**Usage**: `/test-auth [--flows=login,register,reset]`
**Description**: Tests all authentication and authorization flows including edge cases and security scenarios.

#### /test-api-security
API-specific security testing with OWASP compliance.

**Usage**: `/test-api-security [--endpoints=/api/*]`
**Description**: Tests API endpoints for security vulnerabilities following OWASP API Security Top 10 guidelines.

### Advanced Testing Commands

#### /test-coverage
Generate comprehensive code coverage reports.

**Usage**: `/test-coverage [--threshold=80] [--format=html,json]`
**Description**: Generates detailed code coverage reports with configurable thresholds and multiple output formats.

**Implementation**:
```javascript
export const testCoverage = {
  name: 'test-coverage',
  description: 'Generate comprehensive coverage reports',
  parameters: ['threshold', 'format'],
  handler: async (threshold = 80, format = 'html') => {
    const testOrchestrator = await getAgent('autonomous-testing-orchestrator');
    return await testOrchestrator.generateCoverageReport({
      threshold: parseInt(threshold),
      formats: format.split(','),
      includeStatements: true,
      includeBranches: true,
      includeFunctions: true,
      includeLines: true
    });
  }
};
```

#### /test-flaky
Identify and analyze flaky tests.

**Usage**: `/test-flaky [--runs=10] [--fix-suggestions]`
**Description**: Runs tests multiple times to identify flaky tests and provides suggestions for fixing instability.

#### /test-parallel
Run tests in parallel with optimal resource utilization.

**Usage**: `/test-parallel [--workers=auto]`
**Description**: Executes tests in parallel across multiple workers with intelligent resource management.

#### /test-affected
Test only code affected by recent changes.

**Usage**: `/test-affected [--since=HEAD~1]`
**Description**: Uses git diff analysis to run only tests affected by recent code changes for faster feedback.

#### /test-regression
Run regression test suite for critical functionality.

**Usage**: `/test-regression [--suite=smoke,critical]`
**Description**: Executes regression tests focusing on critical functionality and previously identified bug-prone areas.

### Test Management Commands

#### /test-generate
Auto-generate tests based on code analysis.

**Usage**: `/test-generate [--type=unit] [--coverage-gaps]`
**Description**: Uses AI to generate test cases based on code analysis, focusing on uncovered code paths and edge cases.

#### /test-maintain
Maintain and update existing test suites.

**Usage**: `/test-maintain [--outdated] [--broken]`
**Description**: Identifies and fixes outdated or broken tests, updates test data, and improves test reliability.

#### /test-optimize
Optimize test suite performance and reliability.

**Usage**: `/test-optimize [--speed] [--stability]`
**Description**: Analyzes test suite performance and implements optimizations for faster execution and improved stability.

### Test Reporting Commands

#### /test-report
Generate comprehensive test execution reports.

**Usage**: `/test-report [--format=html] [--include-trends]`
**Description**: Generates detailed test reports with execution statistics, trends, and actionable insights.

#### /test-dashboard
Launch interactive test dashboard.

**Usage**: `/test-dashboard [--port=3001]`
**Description**: Launches web-based test dashboard with real-time test status, coverage metrics, and historical trends.

#### /test-compare
Compare test results across different versions or branches.

**Usage**: `/test-compare [--baseline=main] [--current=feature-branch]`
**Description**: Compares test results between different git branches or versions to identify regressions.

### Continuous Testing Commands

#### /test-watch
Start continuous testing with file change monitoring.

**Usage**: `/test-watch [--tests=affected]`
**Description**: Monitors file changes and automatically runs relevant tests with intelligent test selection.

#### /test-ci
Run CI-optimized test suite.

**Usage**: `/test-ci [--stage=pr] [--parallel]`
**Description**: Executes tests optimized for CI/CD pipeline with appropriate test selection based on pipeline stage.

#### /test-schedule
Schedule automated test execution.

**Usage**: `/test-schedule [--cron="0 2 * * *"] [--suite=nightly]`
**Description**: Schedules automated test execution with cron-like scheduling and configurable test suites.

## Integration with Autonomous Testing Orchestrator

All testing commands integrate with the Autonomous Testing Orchestrator agent to provide:

- **Intelligent Test Selection**: Smart test selection based on code changes and risk analysis
- **Parallel Execution**: Optimal parallel test execution across multiple workers
- **Comprehensive Reporting**: Detailed reports with actionable insights and trends
- **Quality Gates**: Automated quality gates with configurable failure thresholds

## Command Configuration

Add these commands to your Claude Code configuration:

```json
{
  "commands": {
    "test-full": {
      "agent": "autonomous-testing-orchestrator",
      "priority": "high",
      "timeout": "30m",
      "resources": "high"
    },
    "test-affected": {
      "agent": "autonomous-testing-orchestrator",
      "priority": "high",
      "gitIntegration": true,
      "smartSelection": true
    },
    "test-security": {
      "agent": "autonomous-testing-orchestrator",
      "priority": "critical",
      "complianceReporting": true,
      "alertOnFailure": true
    }
  }
}
```

## Test Automation Integration

### Git Hook Integration
- **Pre-commit**: Run affected tests before commits
- **Pre-push**: Run comprehensive test suite before pushing
- **Post-merge**: Run integration tests after merges
- **Release**: Run full test suite including security and performance

### CI/CD Pipeline Integration
- **Pull Request**: Run affected tests with coverage reporting
- **Staging Deployment**: Run integration and E2E tests
- **Production Deployment**: Run smoke tests and health checks
- **Scheduled**: Run comprehensive test suite on schedule

### Quality Gates
- **Code Coverage**: Enforce minimum coverage thresholds
- **Performance**: Block deployments on performance regressions
- **Security**: Block on critical security vulnerabilities
- **Stability**: Prevent deployments with flaky test failures