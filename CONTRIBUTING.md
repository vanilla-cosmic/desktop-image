# **Singularity OS - Contribution Guidelines**  

### **Community Participation & Project Direction**  

The community is welcome to join discussions, suggest features, and provide feedback. However, **Singularity OS follows my personal vision of development**. While I value input, final decisions will be made based on my direction and experimentation.  

I encourage constructive discussions, but:  
- Suggestions are considered, not guaranteed to be implemented.  
- Persistent insistence on changes will not be entertained.  
- Discussions that become repetitive or overly insistent will be closed immediately.  

This project is a space for experimentation, and contributions should align with its philosophy. By participating, you acknowledge and respect these principles.  

## **Issues & Tasks**  

- Every contribution should be linked to a **GitHub issue**.  
- The issue title should be **clear and concise**, with a description explaining the purpose.  
- Use `[feat]` for new features and `[fix]` for bug fixes.  

## **Commits**  

All commits should reference their related issue and follow this format:  

```txt
type: [#TaskId] Task Title

Description after a blank line
```

Example:  

```txt
feat: [#123] New file manager integration

Added experimental support for a custom file manager.
```

When closing an issue, use:  

```txt
feat: [close #123] New file manager integration complete
```

## **Merge Requests (Pull Requests)**  

- **All changes must go through a Merge Request (MR).**  
- The **Rebase and Merge** option should be used to keep a clean commit history.  
- Direct commits to `main` are not allowed (except by me or allowed people).
