# Utils

<!-- Index A - Z (auto-generated. Remove this line if manually adding/removing entries) -->

<!-- toc -->
<!-- toc stop -->

## M

### ModuleQualificationUtil

<!-- Begin ModuleQualificationUtil -->

```cs
public static class ModuleQualificationUtil
{
  public static string GetModuleName(IPsiModule psiModule);
  public static string GetModuleQualification(IPsiModule module, IModuleReferenceResolveContext context);
  public static string GetTypeName(IXmlAttributeValue value, out AssemblyNameInfo assemblyName);
  public static TreeTextRange GetTypeNameCompletionRange(string text, TreeOffset offset);
  public static TextRange GetTypeNameFullRange(string text, int offset);

  public static bool IsIdentifierChar(Char c);
  public static bool IsTypeNameChar(Char c);

  public static ICollection<ITypeElement> ResolveType(string clrName, IPsiModule module, bool caseSensitive, IModuleReferenceResolveContext context);
}
```

<!-- End ModuleQualificationUtil -->

Helper methods to support references to CLR types inside XML documents, e.g. web.config files.

* `GetModuleName` returns the name of the given module, e.g. if it's a project, then return the assembly name, else return the module's name.
* `GetModuleQualification` returns the fully qualified assembly name of the module, either the compiled assemblies name, or the name built up from the project settings.
* `GetTypeName` returns a CLR type name and assembly name info from an assembly qualified type name specified in an XML attribute. Defers to `JetBrains.Metadata.Utils.ModuleQualificationUtil.GetTypeName`.
* `GetTypeNameCompletionRange` takes in a string and a starting offset and works out from the text where a type name will start and end, by walking backwards from the start while `IsTypeNameChar` is true, and walking forwards while `IsIdentifierChar` is true.
* `GetTypeNameFullRange` returns the full range of a type name inside a given string. This is different to `GetTypeNameCompletionRange` by allowing type name characters after the start offset, which allows for the current offset to be in a namespace, or for the type name to include nested types.
* `IsIdentifierChar` returns `true` if the given character is a letter, digit or the underscore symbol (`_`).
* `IsTypeNameChar` returns `true` if the given character is a letter, digit, or either an underscore, period, plus or backtick symbol (`_`, `.`, `+` or `\``).
* `ResolveType` retrieves a collection of `ITypeElement` instances for the given CLR name, using an `ISymbolScope` retrieved via `IPsiServices.Symbols`.

## R

### ReferenceWithTokenUtil

<!-- Begin ReferenceWithTokenUtil -->

```cs
public static class ReferenceWithTokenUtil
{
  public static void AddRestoreTransactionAction(IPsiServices psiServices, IReferenceWithToken referenceWithToken, ElementRange<IXmlToken> oldRange);

  public static IXmlToken SetText(IXmlToken token, TreeTextRange oldRange, string newText, ITreeNode elementToDropReferences);
  public static IReferenceWithToken SetText(IReferenceWithToken reference, string newText);
}
```

<!-- End ReferenceWithTokenUtil -->

Helper methods for handling references within a token node. The methods defer to `ReferenceWithinElementUtil<IXmlToken>`. The `SetText` methods provide a factory method to create an appropriate token to replace the existing element.

## X

### XmlAttributeContainerExtensions

<!-- Begin XmlAttributeContainerExtensions -->

```cs
public static class XmlAttributeContainerExtensions
{
  public static TAttribute GetAttribute<TAttribute>(IXmlAttributeContainer container);
  public static IXmlAttribute GetAttribute(IXmlAttributeContainer container, Predicate<IXmlAttribute> predicate);
  public static IXmlAttribute GetAttribute(IXmlAttributeContainer container, string fullName);
}
```

<!-- End XmlAttributeContainerExtensions -->

Gets an attribute from an instance of [`IXmlAttributeContainer`](TreeNodes.md#ixmlattributecontainer) either of a specific derived type, or matching a predicate, or based on name (including namespace prefix, if specified).

### XmlAttributeExtension

<!-- Begin XmlAttributeExtension -->

```cs
public static class XmlAttributeExtension
{
  public static string GetUnquotedText(IXmlAttribute attribute, out TreeTextRange range);
  public static DocumentRange GetUnquotedValueRange(IXmlAttribute attribute);
}
```

<!-- End XmlAttributeExtension -->

Helper methods to get information about the unquoted text of an instance of [`IXmlAttribute`](TreeNodes.md#ixmlattribute). `GetUnquotedText` will return the unquoted text, as well as the tree range of the value. It is better to use the properties on [`IXmlValueToken`](TreeNodes.md#ixmlvaluetoken), as that implementation will cache the values for repeated calls. `GetUnquotedValueRange` returns the range of the unquoted value, relative to the document the XML PSI is hosted inside (this might be an XML file, or an XML island inside another doucment).

### XmlAttributeExtensions

<!-- Begin XmlAttributeExtensions -->

```cs
public static class XmlAttributeExtensions
{
  public static void Remove(IXmlAttribute xmlAttribute);
}
```

<!-- End XmlAttributeExtensions -->

Convenience method. Will remove the given attribute from it's parent tag via `IXmlTag.RemoveAttribute()`, or directly removes it from the tree if it's not a child of a tag.

### XmlAttributeUtil

<!-- Begin XmlAttributeUtil -->

```cs
public static class XmlAttributeUtil
{
  public static void SetValue(IXmlAttribute attribute, string unquotedValue);

  public static DocumentRange UnquotedValueDocumentRange(IXmlAttribute attribute);
  public static TreeTextRange UnquotedValueRange(IXmlAttribute attribute);
}
```

<!-- End XmlAttributeUtil -->

Helper methods for working with XML attributes. `SetValue` replaces an attributes value by creating a new instance of `IXmlAttributeValue` and modifying the tree (it takes the write lock, so the caller doesn't have to). The other methods return the range of the unquoted value of the attribute, relative to the tree, and relative to the document. These may be different if the XML `IFile` is not the primary PSI tree in the file.

### XmlElementFactoryExtensions

<!-- Begin XmlElementFactoryExtensions -->

```cs
public static class XmlElementFactoryExtensions
{
  public static IXmlAttribute CreateAttributeRaw(IXmlElementFactory factory, string attributeText);
  public static IXmlFile CreateFileRaw(IXmlElementFactory factory, string xmlText);
}
```

<!-- End XmlElementFactoryExtensions -->

Creates an instance of [`IXmlFile`](TreeNodes.md#ixmlfile) or [`IXmlAttribute`](TreeNodes.md#ixmlattribute) using the passed in `IXmlElementFactory` without putting the created file into a sandbox. The resulting node is essentially not fully initialised - it is not part of a file, and not part of a sandbox, either.

### XmlReferenceUtil

<!-- Begin XmlReferenceUtil -->

```cs
public static class XmlReferenceUtil
{
  public static TReference FindReferenceRecursively<TReference>(ITreeNode element, Predicate<TReference> predicate);
}
```

<!-- End XmlReferenceUtil -->

Helper method that will recursively walk down the PSI tree starting at `element`, looking for a particular reference, as decided by `predicate`.

### XmlTagExtensions

<!-- Begin XmlTagExtensions -->

```cs
public static class XmlTagExtensions
{
  public static IXmlAttribute GetAttribute(IXmlTag tag, Predicate<IXmlAttribute> predicate);
  public static IXmlAttribute GetAttribute(IXmlTag tag, string fullName);
  public static TreeNodeEnumerable<IXmlAttribute> GetAttributes(IXmlTag tag);
  public static string GetFullTagName(IXmlTag tag);
  public static IXmlIdentifier GetName(IXmlTag tag);
  public static IXmlIdentifier GetNameNode(IXmlTag tag);
  public static string GetTagName(IXmlTag tag);
  public static string GetTagNamespace(IXmlTag tag);

  public static void Remove(IXmlTag xmlTag);
}
```

<!-- End XmlTagExtensions -->

Convenience methods that call into properties and methods on [`IXmlTag`](TreeNodes.md#ixmltag) and child nodes. E.g. `GetTagName` returns `tag.Header.Name.XmlName`, and `Remove` finds the tag's parent [`IXmlTagContainer`](TreeNodes.md#ixmltagcontainer) and calls `IXmlTagContainer.RemoveTag`.

### XmlTagUtil

<!-- Begin XmlTagUtil -->

```cs
public static class XmlTagUtil
{
  public static bool CanBeEmptyTag(IXmlTag tag);

  public static void MakeCompound(IXmlTag tag);
  public static void MakeEmptyTag(IXmlTag tag);
}
```

<!-- End XmlTagUtil -->

Helper methods for working with `IXmlTag`.

* `CanBeEmptyTag` returns `true` if the given tag doesn't have any significant children (e.g. anything other than whitespace), and checks that the current XML language supports converting this tag to be empty, by calling `IXmlLanguageSupport.CanMakeTagEmpty`.
* `MakeCompound` converts an empty, self-closed tag to an empty tag with a header and footer, (e.g. `<foo></foo>`). Modifies the tree, taking the write lock.
* `MakeEmpty` removes all inner nodes and the footer, and converts the header into a self-closing tag (e.g. `<foo />`). Modifies the tree, taking the write lock.

### XPathUtil

<!-- Begin XPathUtil -->

```cs
public static class XPathUtil
{
  public static IList<T> GetNestedTags<T>(IXmlTagContainer container, string xpath);
}
```

<!-- End XPathUtil -->

Walks the child tags of the `container` until it has satisfied the given XPath-like expression. The `xpath` parameter isn't really an XPath string, but XPath-like. The path must be relative to the current `container`, and walks down the tree comparing the tag names at each level with the current path segment name. If the name matches, or the path segment is the wildcard symbol `*`, the walk continues. The tags that match the last path segment name are returned as part of the list.

