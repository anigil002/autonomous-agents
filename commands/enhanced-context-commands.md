# Enhanced Context Commands

## Context Management Commands
Advanced slash commands for comprehensive project context management and session continuity.

### Core Context Commands

#### /update-context
Update contextdetailer.txt with current project state.

**Usage**: `/update-context`
**Description**: Analyzes current project state and updates the comprehensive context documentation including file changes, dependencies, test coverage, and development progress.

**Implementation**:
```javascript
export const updateContext = {
  name: 'update-context',
  description: 'Update comprehensive project context documentation',
  parameters: [],
  handler: async () => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.updateContext({
      includeFileStructure: true,
      includeDependencyAnalysis: true,
      includeTestCoverage: true,
      includePerformanceMetrics: true,
      includeSecurityStatus: true,
      includeDeploymentStatus: true
    });
  }
};
```

#### /context-summary
Generate quick context summary for current session.

**Usage**: `/context-summary`
**Description**: Generates a concise summary of current project state, recent changes, and immediate priorities for quick orientation.

**Implementation**:
```javascript
export const contextSummary = {
  name: 'context-summary',
  description: 'Generate quick context summary',
  parameters: [],
  handler: async () => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.generateSummary({
      includeRecentChanges: true,
      includePriorityTasks: true,
      includeKnownIssues: true,
      includeNextSteps: true
    });
  }
};
```

#### /context-search <term>
Search through comprehensive project context.

**Usage**: `/context-search authentication`
**Description**: Performs intelligent search through project context including code, documentation, dependencies, and architectural decisions.

**Implementation**:
```javascript
export const contextSearch = {
  name: 'context-search',
  description: 'Search through project context intelligently',
  parameters: ['searchTerm'],
  handler: async (searchTerm) => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.searchContext(searchTerm, {
      searchCode: true,
      searchDocumentation: true,
      searchArchitecturalDecisions: true,
      searchIssues: true,
      includeRelevanceScoring: true
    });
  }
};
```

#### /context-reset
Reset context for new development phase.

**Usage**: `/context-reset`
**Description**: Resets project context for major development phase transitions while preserving essential historical information.

**Implementation**:
```javascript
export const contextReset = {
  name: 'context-reset',
  description: 'Reset context for new development phase',
  parameters: [],
  handler: async () => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.resetContext({
      preserveArchitecturalDecisions: true,
      preserveSecurityConfiguration: true,
      preserveDependencyHistory: true,
      resetTaskTracking: true,
      resetProgressMetrics: true
    });
  }
};
```

#### /context-diff
Show context changes since last update.

**Usage**: `/context-diff`
**Description**: Displays detailed diff of context changes since last update, highlighting what has changed in the project state.

### Advanced Context Commands

#### /context-analyze-structure
Deep dive analysis of project structure and relationships.

**Usage**: `/context-analyze-structure`
**Description**: Performs comprehensive analysis of project structure, identifying dependencies, circular references, and architectural patterns.

**Implementation**:
```javascript
export const contextAnalyzeStructure = {
  name: 'context-analyze-structure',
  description: 'Deep analysis of project structure and relationships',
  parameters: [],
  handler: async () => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.analyzeStructure({
      analyzeDependencies: true,
      identifyCircularReferences: true,
      analyzeArchitecturalPatterns: true,
      generateDependencyGraph: true,
      identifyTechnicalDebt: true
    });
  }
};
```

#### /context-analyze-dependencies
Check dependency health and update requirements.

**Usage**: `/context-analyze-dependencies`
**Description**: Analyzes all project dependencies for security vulnerabilities, available updates, and compatibility issues.

**Implementation**:
```javascript
export const contextAnalyzeDependencies = {
  name: 'context-analyze-dependencies',
  description: 'Comprehensive dependency health analysis',
  parameters: [],
  handler: async () => {
    const contextAgent = await getAgent('context-detailer');
    return await contextAgent.analyzeDependencies({
      checkSecurity: true,
      checkUpdates: true,
      checkCompatibility: true,
      analyzeLicenses: true,
      identifyUnused: true
    });
  }
};
```

#### /context-analyze-performance
Generate performance context and optimization opportunities.

**Usage**: `/context-analyze-performance`
**Description**: Analyzes current performance metrics and identifies optimization opportunities across the entire stack.

#### /context-analyze-security
Security posture analysis and recommendations.

**Usage**: `/context-analyze-security`
**Description**: Comprehensive security analysis including vulnerabilities, configuration issues, and compliance status.

### Context Session Management

#### /context-session-start <session-name>
Start new development session with context tracking.

**Usage**: `/context-session-start feature-auth`
**Description**: Starts a new development session with dedicated context tracking and goal setting.

#### /context-session-end
End current development session with summary generation.

**Usage**: `/context-session-end`
**Description**: Ends current development session and generates comprehensive session summary with handoff instructions.

#### /context-handoff
Generate comprehensive handoff documentation.

**Usage**: `/context-handoff`
**Description**: Creates detailed handoff documentation for seamless developer transition including context, priorities, and next steps.

### Context Intelligence Commands

#### /context-predict-impact <change-description>
Predict impact of proposed changes on project.

**Usage**: `/context-predict-impact "switch from Express to Fastify"`
**Description**: Uses project context to predict the impact of proposed changes across all system components.

#### /context-recommend-tasks
Get AI-recommended next tasks based on project context.

**Usage**: `/context-recommend-tasks`
**Description**: Analyzes project context to recommend prioritized next tasks based on current state and goals.

#### /context-identify-risks
Identify potential risks based on current project context.

**Usage**: `/context-identify-risks`
**Description**: Analyzes project context to identify potential technical, security, and performance risks.

### Context Export Commands

#### /context-export-full
Export complete project context in multiple formats.

**Usage**: `/context-export-full`
**Description**: Exports comprehensive project context in Markdown, JSON, and PDF formats for documentation and sharing.

#### /context-export-summary
Export concise context summary for stakeholders.

**Usage**: `/context-export-summary`
**Description**: Exports executive summary of project context suitable for non-technical stakeholders.

#### /context-export-technical
Export technical context for developers.

**Usage**: `/context-export-technical`
**Description**: Exports detailed technical context including architecture, dependencies, and development setup information.

## Context Visualization Commands

#### /context-visualize-architecture
Generate visual architecture diagrams from context.

**Usage**: `/context-visualize-architecture`
**Description**: Creates visual architecture diagrams based on analyzed project structure and dependencies.

#### /context-visualize-dependencies
Generate dependency visualization graphs.

**Usage**: `/context-visualize-dependencies`
**Description**: Creates interactive dependency graphs showing package relationships and update requirements.

#### /context-visualize-timeline
Generate project timeline visualization.

**Usage**: `/context-visualize-timeline`
**Description**: Creates timeline visualization showing project development progress and major milestones.

## Integration with Context Detailer Agent

All context commands integrate with the Context Detailer agent to provide:

- **Comprehensive State Tracking**: Full project state documentation and tracking
- **Intelligent Analysis**: AI-powered analysis of project structure and dependencies
- **Session Continuity**: Seamless handoff between development sessions
- **Predictive Intelligence**: Impact prediction and risk analysis capabilities

## Command Configuration

Add these commands to your Claude Code configuration:

```json
{
  "commands": {
    "update-context": {
      "agent": "context-detailer",
      "priority": "high",
      "autoTrigger": ["file-change", "dependency-update"],
      "hooks": ["pre-commit", "post-deploy"]
    },
    "context-search": {
      "agent": "context-detailer",
      "priority": "medium",
      "searchIndex": true,
      "fuzzySearch": true
    },
    "context-analyze-structure": {
      "agent": "context-detailer",
      "priority": "low",
      "cache": "24h",
      "generateVisuals": true
    }
  }
}
```

## Context Automation

### Automated Context Updates
- **File Change Triggers**: Automatically update context when files are modified
- **Dependency Updates**: Update context when package.json or similar files change
- **Git Events**: Update context on commits, merges, and branch changes
- **Deployment Events**: Update context after successful deployments

### Context Quality Assurance
- **Consistency Checking**: Ensure context remains consistent across updates
- **Completeness Validation**: Verify all important project aspects are documented
- **Freshness Monitoring**: Track context age and trigger updates when needed
- **Accuracy Verification**: Cross-check context against actual project state