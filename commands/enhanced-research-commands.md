# Enhanced Research Commands

## Research Commands
Enhanced slash commands for comprehensive research capabilities using MCP servers.

### Core Research Commands

#### /research-stack <technology>
Research latest versions and best practices for specific technologies.

**Usage**: `/research-stack react`
**Description**: Researches current stable version, best practices, security guidelines, and recent updates for the specified technology using Context7 and GitHub MCPs.

**Implementation**:
```javascript
export const researchStack = {
  name: 'research-stack',
  description: 'Research technology stack components for latest versions and best practices',
  parameters: ['technology'],
  handler: async (technology) => {
    // Use MCP Research Coordinator agent
    const coordinator = await getAgent('mcp-research-coordinator');
    return await coordinator.researchTechnology(technology, {
      includeVersions: true,
      includeBestPractices: true,
      includeSecurityGuidelines: true,
      includeCommunityFeedback: true
    });
  }
};
```

#### /research-patterns <pattern-type>
Research architectural patterns and implementation strategies.

**Usage**: `/research-patterns microservices`
**Description**: Researches architectural patterns, implementation examples, and industry best practices for the specified pattern type.

**Implementation**:
```javascript
export const researchPatterns = {
  name: 'research-patterns',
  description: 'Research architectural patterns and implementation strategies',
  parameters: ['pattern'],
  handler: async (pattern) => {
    const coordinator = await getAgent('mcp-research-coordinator');
    return await coordinator.researchPatterns(pattern, {
      includeImplementationExamples: true,
      includeTradeoffs: true,
      includeScalabilityConsiderations: true
    });
  }
};
```

#### /research-security <domain>
Research security best practices for specific domains.

**Usage**: `/research-security authentication`
**Description**: Researches current security best practices, vulnerability patterns, and mitigation strategies for the specified security domain.

**Implementation**:
```javascript
export const researchSecurity = {
  name: 'research-security',
  description: 'Research security best practices and vulnerability mitigation',
  parameters: ['domain'],
  handler: async (domain) => {
    const coordinator = await getAgent('mcp-research-coordinator');
    return await coordinator.researchSecurity(domain, {
      includeVulnerabilities: true,
      includeMitigationStrategies: true,
      includeComplianceRequirements: true,
      includeSecurityTools: true
    });
  }
};
```

#### /research-performance <area>
Research performance optimization techniques.

**Usage**: `/research-performance database`
**Description**: Researches performance optimization techniques, benchmarks, and monitoring strategies for the specified area.

#### /research-compatibility
Check technology stack compatibility across all components.

**Usage**: `/research-compatibility`
**Description**: Analyzes current project dependencies for compatibility issues, version conflicts, and upgrade paths.

### Advanced Research Commands

#### /research-trends <technology>
Research technology adoption trends and future roadmaps.

**Usage**: `/research-trends nextjs`
**Description**: Researches technology adoption trends, community growth, and official roadmaps to inform technology decisions.

#### /research-alternatives <technology>
Research alternative technologies and migration paths.

**Usage**: `/research-alternatives webpack`
**Description**: Researches alternative technologies, compares features and performance, and provides migration guidance.

#### /research-migration <from> <to>
Research migration strategies between technologies.

**Usage**: `/research-migration express fastify`
**Description**: Researches specific migration strategies, compatibility considerations, and step-by-step migration guides.

#### /research-benchmarks <area>
Research performance benchmarks and comparisons.

**Usage**: `/research-benchmarks orm`
**Description**: Researches performance benchmarks, comparative analysis, and optimization recommendations for the specified area.

#### /research-community <project>
Research community health and project viability.

**Usage**: `/research-community prisma`
**Description**: Researches community health metrics, maintainer activity, issue response times, and long-term viability indicators.

### Research Management Commands

#### /research-cache-status
Check status of research cache and update requirements.

**Usage**: `/research-cache-status`
**Description**: Displays research cache status, freshness indicators, and identifies content needing updates.

#### /research-update-cache
Update research cache with latest information.

**Usage**: `/research-update-cache`
**Description**: Updates research cache across all MCP servers with latest information and best practices.

#### /research-export <format>
Export research findings in specified format.

**Usage**: `/research-export pdf`
**Description**: Exports comprehensive research findings in PDF, Markdown, or JSON format for documentation and sharing.

#### /research-schedule <topic>
Schedule ongoing research monitoring for specific topics.

**Usage**: `/research-schedule security-updates`
**Description**: Sets up automated monitoring for ongoing research in specified topics with customizable alert thresholds.

## Integration with MCP Research Coordinator

All research commands integrate with the MCP Research Coordinator agent to provide:

- **Multi-MCP Coordination**: Queries across Context7, GitHub, and other relevant MCP servers
- **Intelligent Caching**: Caches research results with appropriate expiration times
- **Quality Validation**: Cross-references findings across multiple sources
- **Automated Updates**: Monitors for changes and updates cached research automatically

## Command Configuration

Add these commands to your Claude Code configuration:

```json
{
  "commands": {
    "research-stack": {
      "agent": "mcp-research-coordinator",
      "priority": "high",
      "cache": "24h",
      "mcpServers": ["context7", "github"]
    },
    "research-security": {
      "agent": "mcp-research-coordinator", 
      "priority": "high",
      "cache": "12h",
      "mcpServers": ["context7", "github", "security-db"]
    },
    "research-patterns": {
      "agent": "mcp-research-coordinator",
      "priority": "medium", 
      "cache": "48h",
      "mcpServers": ["context7", "github"]
    }
  }
}
```